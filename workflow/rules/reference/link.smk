rule reference__link__:
    """Make a link to the original forward file, with a prettier name than default"""
    input:
        get_reference_path,
    output:
        REFERENCE / "{reference}.fa.gz",
    log:
        REFERENCE / "{reference}.log",
    conda:
        "__environment__.yml"
    shell:
        """
        ln --symbolic $(readlink --canonicalize {input}) {output} 2> {log}
        """


rule reference__link:
    """Link all reads in the samples.tsv"""
    input:
        [REFERENCE / f"{reference}.fa.gz" for reference in REFERENCES],


localrules:
    reference__link__,
