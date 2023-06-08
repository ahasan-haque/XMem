# XMem

## Long-Term Video Object Segmentation with an Atkinson-Shiffrin Memory Model

[Ho Kei Cheng](https://hkchengrex.github.io/), [Alexander Schwing](https://www.alexander-schwing.de/)

University of Illinois Urbana-Champaign

[[arXiv]](https://arxiv.org/abs/2207.07115) [[PDF]](https://arxiv.org/pdf/2207.07115.pdf) [[Project Page]](https://hkchengrex.github.io/XMem/) [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1RXK5QsUo2-CnOiy5AOSjoZggPVHOPh1m?usp=sharing)

## Data Preparation

You can download your dataset from [Google Drive](https://drive.google.com/drive/folders/1atzmiqPMK3ye2f3nW-cEPnwPpgwnC_cd?usp=sharing). If you want to prepare your own dataset, just follow the same structure.

```
-- datasets
  | 
   -- image
      |
       -- Scene_1
          -- 00000.jpg
          -- 00001.jpg
       -- Scene_2
          -- 00000.jpg
          -- 00001.jpg
   -- gt
      |
       -- Scene_1
          -- 00000.png
          -- 00001.png
       -- Scene_2
          -- 00000.png
          -- 00001.png
   -- annotations
      |
       -- Scene_1
          -- 00000.png [only the first frame is enough]
       -- Scene_2
          -- 00000.png
```

Also, if you run the application through Docker, create an **output** directory at project root, which will be mounted to store the segmented images.

## Testing

1\. Create a *"saves"* directory, download the model in the following way, and make sure the pre-trained models are in your *"saves"* directory.

```
wget https://github.com/hkchengrex/XMem/releases/download/v1.0/XMem-s012.pth
```

2\. Install the dependencies.

```
pip install -r requirements.txt
```

3\. Run the following line to start the evaluation:
```
python eval.py  --d17_path dataset_root --split test --model ./saves/XMem-s012.pth --output ./output_path
```

## Running in docker

You can run a docker container with the following command:
```
docker build -t xmem . && \
docker run -it --rm -v RGB_IMAGE_PATH:/images \ 
-v GT_IMAGE_PATH:/gt  \
-v ANNOTATIONS_PATH:/annotations \
--gpus all --shm-size=2gb xmem
```

For example, this is the exact command is run locally:

```
docker build -t xmem . && \
docker run -it --rm -v C:\Users\ge79pih\tmo_data\tmo\tmo_dataset:/images \ 
-v C:\Users\ge79pih\tmo_data\tmo\tmo_gt:/gt  \
-v C:\Users\ge79pih\tmo_data\tmo\tmo_annotations:/annotations \
--gpus all --shm-size=2gb xmem
```

## License
The skeleton of this project is taken from [Official XMem Implementation](https://github.com/hkchengrex/XMem). If you want more detail about the workflow, please refer to the official repository.
