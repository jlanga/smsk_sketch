include: "__functions__.smk"
include: "sketch.smk"
include: "index.smk"
include: "search.smk"
include: "compare.smk"


# include: "gather.smk"  # not implemented yet


rule sourmash:
    input:
        # rules.sourmash__sketch__reads.input,
        # rules.sourmash__sketch__genomes.input,
        # rules.sourmash__index.input,
        rules.sourmash__search.input,
        rules.sourmash__compare.input,
        # rules.sourmash__gather.input,
