package valuesYaml

// ISCSIOptions represents the schema for iSCSI Options.
type ISCSIOptions struct {
    TargetPortal  string        `yaml:"targetPortal" schema:"type:string,required:true" description:"targetPortal"`
    IQN           string        `yaml:"iqn" schema:"type:string,required:true" description:"iqn"`
    LUN           int           `yaml:"lun" schema:"type:int,default:0" description:"lun"`
    AuthSession   AuthSession   `yaml:"authSession" schema:"type:dict,additional_attrs:true" description:"authSession"`
    AuthDiscovery AuthDiscovery `yaml:"authDiscovery" schema:"type:dict,additional_attrs:true" description:"authDiscovery"`
}

// AuthSession represents the schema for authentication session in iSCSI Options.
type AuthSession struct {
    Username          string `yaml:"username" schema:"type:string" description:"username"`
    Password          string `yaml:"password" schema:"type:string" description:"password"`
    UsernameInitiator string `yaml:"usernameInitiator" schema:"type:string" description:"usernameInitiator"`
    PasswordInitiator string `yaml:"passwordInitiator" schema:"type:string" description:"passwordInitiator"`
}

// AuthDiscovery represents the schema for authentication discovery in iSCSI Options.
type AuthDiscovery struct {
    Username          string `yaml:"username" schema:"type:string" description:"username"`
    Password          string `yaml:"password" schema:"type:string" description:"password"`
    UsernameInitiator string `yaml:"usernameInitiator" schema:"type:string" description:"usernameInitiator"`
    PasswordInitiator string `yaml:"passwordInitiator" schema:"type:string" description:"passwordInitiator"`
}

// AutoPermissions represents the schema for Automatic Permissions Configuration.
type AutoPermissions struct {
    Enabled   bool   `yaml:"enabled" schema:"type:boolean,default:false,show_subquestions_if:true" description:"enabled"`
    Chown     bool   `yaml:"chown" schema:"show_if:[[enabled,=,true]],type:boolean,default:false" description:"Run CHOWN"`
    Chmod     string `yaml:"chmod" schema:"show_if:[[enabled,=,true]],type:string,valid_chars:'[0-9]{3}'" description:"Run CHMOD"`
    Recursive bool   `yaml:"recursive" schema:"show_if:[[enabled,=,true]],type:boolean,default:false" description:"Recursive"`
}

// HostPathOptions represents the schema for Host Path Options.
type HostPathOptions struct {
    Path string `yaml:"path" schema:"type:string,required:true" description:"Path inside the container the storage is mounted"`
}

// StaticBinding represents the schema for Static Fixed PVC Bindings.
type StaticBinding struct {
    Mode     string `yaml:"mode" schema:"type:string,default:disabled,enum:disabled,smb,nfs" description:"mode"`
    Server   string `yaml:"server" schema:"show_if:[[mode,!=,disabled]],type:string,default:'myserver'" description:"Server"`
    Share    string `yaml:"share" schema:"show_if:[[mode,!=,disabled]],type:string,default:'/myshare'" description:"Share"`
    User     string `yaml:"user" schema:"show_if:[[mode,=,smb]],type:string,default:'myuser'" description:"User"`
    Domain   string `yaml:"domain" schema:"show_if:[[mode,=,smb]],type:string" description:"Domain"`
    Password string `yaml:"password" schema:"show_if:[[mode,=,smb]],type:string" description:"Password"`
}

// VolumeSnapshot represents the schema for Volume Snapshots.
type VolumeSnapshot struct {
    Name                    string `yaml:"name" schema:"type:string,default:mysnapshot" description:"Name"`
    VolumeSnapshotClassName string `yaml:"volumeSnapshotClassName" schema:"type:string" description:"volumeSnapshot Class Name (Advanced)"`
}

// Persistence represents the schema for Integrated Persistent Storage.
type Persistence struct {
    Name            string           `yaml:"name,omitempty" schema:"type:string" description:"Custom storage name"`
    Enabled         bool             `yaml:"enabled" schema:"type:boolean,default:true,hidden:true" description:"Enable Integrated Persistent Storage"`
    Type            string           `yaml:"type" schema:"type:string,default:pvc,enum:pvc,hostPath,emptyDir,nfs,iscsi" description:"Sets the persistence type, Anything other than PVC could break rollback!"`
    Server          string           `yaml:"server" schema:"show_if:[[type,=,nfs]]type:string default:''" description:"NFS Server"`
    Path            string           `yaml:"path" schema:"show_if:[[type,=,nfs]],type:string" description:"Path on NFS Server"`
    ISCSI           ISCSIOptions     `yaml:"iscsi" schema:"show_if:[[type,=,iscsi]],type:dict,additional_attrs:true" description:"iSCSI Options"`
    AutoPermissions AutoPermissions  `yaml:"autoPermissions" schema:"show_if:[[type,!=,pvc]],type:dict,additional_attrs:true" description:"Automatic Permissions Configuration"`
    ReadOnly        bool             `yaml:"readOnly" schema:"type:boolean,default:false" description:"Read Only"`
    HostPath        HostPathOptions  `yaml:"hostPath" schema:"show_if:[[type,=,hostPath]],type:hostpath" description:"Host Path"`
    MountPath       string           `yaml:"mountPath" schema:"type:string,required:true,valid_chars:^\\/([a-zA-Z0-9._-]+(\\s?[a-zA-Z0.9._-]+|\\/?)$" description:"Path inside the container the storage is mounted"`
    Medium          string           `yaml:"medium" schema:"show_if:[[type,=,emptyDir]],type:string,enum:'Memory'" description:"EmptyDir Medium"`
    Size            string           `yaml:"size" schema:"show_if:[[type,=,pvc]],type:string,default:256Gi" description:"Size Quotum of Storage"`
    StorageClass    string           `yaml:"storageClass" schema:"show_if:[[type,=,pvc]],type:string" description:"storageClass (Advanced)"`
    Static          StaticBinding    `yaml:"static" schema:"show_if:[[type,=,pvc]],type:dict,additional_attrs:true" description:"Static Fixed PVC Bindings (Experimental)"`
    VolumeSnapshots []VolumeSnapshot `yaml:"volumeSnapshots" schema:"show_if:[[type,=,pvc]],type:list,default:[]" description:"Volume Snapshots (Experimental)"`
}
