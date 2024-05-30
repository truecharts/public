---
title: Fabulinus Installation Notes
---

Set the `Device` to **CPU** or **GPU** depending on the image selected.

Set the `Model` to a supported model from the following [list](https://docs.titanml.co/docs/titan-takeoff/experimentation/supported-models).

Set the `Quant Type` to the correct option when using a particular model.

Set the `Max Batch Size` to the maximum batch size a model can use.

:::tip

If you are not using the batching endpoint, /generate, it is best practice to set `Disable Batching` to true. The batching service can interfere with the streaming service, and make it slower.

:::
