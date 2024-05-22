include: "__functions__.smk"
include: "sketch.smk"
include: "query.smk"
include: "profile.smk"


rule sylph:
    input:
        rules.sylph__sketch.input,
        rules.sylph__query.input,
        rules.sylph__profile.input,
