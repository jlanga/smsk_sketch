#!/usr/bin/env bash

set -euo pipefail

mkdir \
    --parents \
    resources/genomes \
    resources/reads

pushd resources/genomes

wget \
    --continue \
    https://ftp.ensembl.org/pub/release-112/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.22.fa.gz \
    https://ftp.ensembl.org/pub/release-112/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.chromosome.19.fa.gz \
    https://ftp.ensembl.org/pub/release-112/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.chromosome.25.fa.gz

popd

wgsim \
    -N 10000 \
    -1 150 \
    -2 150 \
    resources/genomes/Homo_sapiens.GRCh38.dna.chromosome.22.fa.gz \
    >(seqtk seq -F I | gzip -9 > resources/reads/human_1.fq.gz) \
    >(seqtk seq -F I | gzip -9 > resources/reads/human_2.fq.gz)

wgsim \
    -N 10000 \
    -1 150 \
    -2 150 \
    resources/genomes/Mus_musculus.GRCm39.dna.chromosome.19.fa.gz \
    >(seqtk seq -F I | gzip -9 > resources/reads/mouse_1.fq.gz) \
    >(seqtk seq -F I | gzip -9 > resources/reads/mouse_2.fq.gz)

wgsim \
    -N 10000 \
    -1 150 \
    -2 150 \
    resources/genomes/Danio_rerio.GRCz11.dna.chromosome.25.fa.gz \
    >(seqtk seq -F I | gzip -9 > resources/reads/zebrafish_1.fq.gz) \
    >(seqtk seq -F I | gzip -9 > resources/reads/zebrafish_2.fq.gz)
