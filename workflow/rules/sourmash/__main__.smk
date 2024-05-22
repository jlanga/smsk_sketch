include: "__functions__.smk"
include: "sketch.smk"


rule sourmash:
    input:
        rules.sourmash__sketch__reads.input,
        rules.sourmash__sketch__genomes.input,
