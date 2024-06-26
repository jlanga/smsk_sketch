rule raw_download_tarball:
    """Download tarball with reads and reference"""
    output:
        tarball=RAW + "snakemake-tutorial-data.tar.gz",
    log:
        RAW + "download_tarball.log",
    conda:
        "raw.yml"
    params:
        url=features["urls"]["tarball"],
    shell:
        """
        wget \
            --continue \
            --output-document {output.tarball} \
            {params.url} \
        2> {log} 1>&2
        """


rule raw_extract_genome:
    """Extract from the tarball just the reference"""
    input:
        tarball=RAW + "snakemake-tutorial-data.tar.gz",
    output:
        touch(RAW + "genome.fa"),
    log:
        RAW + "extract_genome.log",
    conda:
        "raw.yml"
    shell:
        """
        tar \
            --extract \
            --verbose \
            --file {input.tarball} \
            --directory {RAW} \
            --strip 1 \
            data/genome.fa \
        2> {log} 1>&2
        """


rule raw_extract_samples:
    """Extract from the tarball the fastq files"""
    input:
        tarball=RAW + "snakemake-tutorial-data.tar.gz",
    output:
        a=touch(RAW + "samples/A.fastq"),
        b=touch(RAW + "samples/B.fastq"),
    log:
        RAW + "extract_genome.log",
    conda:
        "raw.yml"
    params:
        a_path="data/samples/A.fastq",
        b_path="data/samples/B.fastq",
    shell:
        """
        tar \
            --extract \
            --verbose \
            --file {input.tarball} \
            --directory {RAW} \
            --strip 1 \
            {params.a_path} {params.b_path} \
        2> {log} 1>&2
        """
