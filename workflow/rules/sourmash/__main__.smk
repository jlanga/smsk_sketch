include: "__functions__.smk"
include: "sketch.smk"
include: "index.smk"
include: "search.smk"
include: "compare.smk"


rule sourmash:
    input:
        rules.sourmash__search.input,
        rules.sourmash__compare.input,
