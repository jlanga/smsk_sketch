rule genomes__link__:
    """Make a link to the original forward file, with a prettier name than default"""
    input:
        get_genome_path,
    output:
        GENOMES / "{genome}.fa.gz",
    log:
        GENOMES / "{genome}.log",
    conda:
        "__environment__.yml"
    shell:
        """
        ln --symbolic $(readlink --canonicalize {input}) {output} 2> {log}
        """


rule genomes__link:
    """Link all reads in the samples.tsv"""
    input:
        [GENOMES / f"{genome}.fa.gz" for genome in GENOME_LIST],


localrules:
    genomes__link__,
