#!/usr/bin/env bash

set -euo pipefail

mkdir \
    --parents \
    resources/references \
    resources/reads

pushd resources/references

wget \
    --continue \
    https://ftp.ensembl.org/pub/release-112/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.MT.fa.gz \
    https://ftp.ensembl.org/pub/release-112/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.chromosome.MT.fa.gz \
    https://ftp.ensembl.org/pub/release-112/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.chromosome.MT.fa.gz

popd

wgsim \
    -N 10000 \
    -1 150 \
    -2 150 \
    resources/references/Homo_sapiens.GRCh38.dna.chromosome.MT.fa.gz \
    >(seqtk seq -F I | gzip -9 > resources/reads/human_1.fq.gz) \
    >(seqtk seq -F I | gzip -9 > resources/reads/human_2.fq.gz)

wgsim \
    -N 10000 \
    -1 150 \
    -2 150 \
    resources/references/Mus_musculus.GRCm39.dna.chromosome.MT.fa.gz \
    >(seqtk seq -F I | gzip -9 > resources/reads/mouse_1.fq.gz) \
    >(seqtk seq -F I | gzip -9 > resources/reads/mouse_2.fq.gz)

wgsim \
    -N 10000 \
    -1 150 \
    -2 150 \
    resources/references/Danio_rerio.GRCz11.dna.chromosome.MT.fa.gz \
    >(seqtk seq -F I | gzip -9 > resources/reads/zebrafish_1.fq.gz) \
    >(seqtk seq -F I | gzip -9 > resources/reads/zebrafish_2.fq.gz)
