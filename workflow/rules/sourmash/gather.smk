rule sourmash__gather__:
    input:
        sig=SOUR_READS / "{sample_id}.{library_id}.sig",
        sbt=SOUR_INDEX / "genomes.sbt.zip",
    output:
        csv=SOUR_GATHER / "{sample_id}.{library_id}.csv",
    log:
        SOUR_GATHER / "{sample_id}.{library_id}.log",
    conda:
        "__environment__.yml"
    shell:
        """
        sourmash gather \
            --output {output.csv} \
            {input.sig} \
            {input.sbt} \
        2> {log} 1>&2
        """


rule sourmash__gather:
    input:
        [
            SOUR_GATHER / f"{sample_id}.{library_id}.csv"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],
