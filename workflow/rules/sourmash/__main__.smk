include: "__functions__.smk"
include: "sketch.smk"
include: "index.smk"


rule sourmash:
    input:
        rules.sourmash__sketch__reads.input,
        # rules.sourmash__sketch__genomes.input,
        rules.sourmash__index.input,
