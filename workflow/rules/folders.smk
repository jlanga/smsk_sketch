"""
Folder variables
"""

RESULTS = Path("results")

READS = RESULTS / "reads"
GENOMES = RESULTS / "genomes"

PREPROCESS = RESULTS / "preprocess"
FASTP = PREPROCESS / "fastp"
KHMER = PREPROCESS / "khmer"

SOURMASH = RESULTS / "sourmash"
SOUR_READS = SOURMASH / "reads"
SOUR_GENOMES = SOURMASH / "genomes"
SOUR_INDEX = SOURMASH / "index"
SOUR_SEARCH = SOURMASH / "search"
SOUR_GATHER = SOURMASH / "gather"
