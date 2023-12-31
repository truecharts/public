---
title: Installation Notes
---

A quick run down on the options available for **whisper-asr-webservice**.

The main service runs a Interactive Swagger API documentation is available at `<http://truenas.local:19900/docs>`

## Models

The **ASR Model** has the following values:

| Model  | Required VRAM | Relative speed |
| ------ | ------------- | -------------- |
| tiny   | ~1 GB         | ~32x           |
| base   | ~1 GB         | ~16x           |
| small  | ~2 GB         | ~6x            |
| medium | ~5 GB         | ~2x            |
| large  | ~10 GB        | ~1x            |

Default is **Base**.

## Engines

The **ASR Engine** is default to **Faster Whisper**, explained [here](https://github.com/guillaumekln/faster-whisper#faster-whisper-transcription-with-ctranslate2).

A list of Engines available.

| Engines        |
| -------------- |
| Faster Whisper |
| OpenAI Whisper |

## Cache

> The ASR model is downloaded each time you start the container, using the large model this can take some time. If you want to decrease the time it takes to start your container by skipping the download, you can store the cache directory (/root/.cache/whisper) to an persistent storage. Next time you start your container the ASR Model will be taken from the cache instead of being downloaded again.
> Important this will prevent you from receiving any updates to the models.

You can set the pre-persisted mount **whisper** as emptyDir and set it as default or memory if you have the ram for it.
