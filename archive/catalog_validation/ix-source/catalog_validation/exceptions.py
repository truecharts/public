import errno


class ValidationException(Exception):
    def __init__(self, error_msg, error_no=errno.EFAULT):
        self.errmsg = error_msg
        self.errno = error_no

    def get_error_name(self):
        return errno.errorcode.get(self.errno) or 'EUNKNOWN'

    def __str__(self):
        return f'[{self.get_error_name()}] {self.errmsg}'


class ValidationError(ValidationException):
    def __init__(self, attribute, errmsg, errno=errno.EFAULT):
        self.attribute = attribute
        self.errmsg = errmsg
        self.errno = errno

    def __str__(self):
        return f'[{self.get_error_name()}] {self.attribute}: {self.errmsg}'


class ValidationErrors(ValidationException):
    def __init__(self, errors=None):
        self.errors = errors or []

    def add(self, attribute, errmsg, errno=errno.EINVAL):
        self.errors.append(ValidationError(attribute, errmsg, errno))

    def add_validation_error(self, validation_error):
        self.errors.append(validation_error)

    def add_child(self, attribute, child):
        for e in child.errors:
            self.add(f"{attribute}.{e.attribute}", e.errmsg, e.errno)

    def check(self):
        if self:
            raise self

    def extend(self, errors):
        for e in errors.errors:
            self.add(e.attribute, e.errmsg, e.errno)

    def __iter__(self):
        for e in self.errors:
            yield e.attribute, e.errmsg, e.errno

    def __bool__(self):
        return bool(self.errors)

    def __str__(self):
        output = ''
        for e in self.errors:
            output += str(e) + '\n'
        return output

    def __contains__(self, item):
        return item in [e.attribute for e in self.errors]


class CatalogDoesNotExist(ValidationException):
    def __init__(self, path):
        super().__init__(f'Failed to find a catalog at {path}', errno.ENOENT)
