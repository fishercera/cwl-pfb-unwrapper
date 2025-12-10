{
  "class": "CommandLineTool",
  "cwlVersion": "v1.2",
  "$namespaces": {
    "sbg": "https://sevenbridges.com"
  },
  "baseCommand": [],
  "inputs": [
    {
      "sbg:category": "File Inputs",
      "id": "in_avro",
      "type": "File",
      "label": "Input file in avro format",
      "doc": "Input file in avro format.",
      "sbg:fileTypes": "AVRO"
    },
    {
      "sbg:category": "Execution and Platform",
      "sbg:toolDefaultValue": "1024",
      "id": "mem_per_job",
      "type": "int?",
      "label": "Memory per job [MB]",
      "doc": "Memory per job [MB]."
    },
    {
      "sbg:category": "Execution and Platform",
      "sbg:toolDefaultValue": "1",
      "id": "cpu_per_job",
      "type": "int?",
      "label": "CPUs per job",
      "doc": "CPus per job."
    },
    {
      "sbg:toolDefaultValue": "no",
      "id": "folder_structure",
      "type": [
        "null",
        {
          "type": "enum",
          "symbols": [
            "no",
            "yes"
          ],
          "name": "folder_structure"
        }
      ],
      "inputBinding": {
        "prefix": "--folders",
        "shellQuote": false,
        "position": 1
      },
      "label": "Recapitulate Folder Structure",
      "doc": "By default, folders and flattened and all files appear in root folder. If a folder structure is available, select 'yes' to recapitulate this structure within the project.\n\nYes = folder structure preserved\nNo = flattened",
      "default": "No"
    }
  ],
  "outputs": [
    {
      "id": "out_nodes",
      "doc": "TSV files for all nodes in input PFB.",
      "label": "TSV files for all nodes in input PFB",
      "type": "Directory?",
      "outputBinding": {
        "glob": "*_tsvs",
        "loadListing": "deep_listing"
      }
    },
    {
      "id": "out_schema",
      "doc": "Schema of the PFB file.",
      "label": "Schema of the PFB file",
      "type": "File?",
      "outputBinding": {
        "glob": "*schema.json",
        "outputEval": "$(inheritMetadata(self, inputs.in_avro))"
      },
      "sbg:fileTypes": "JSON"
    },
    {
      "id": "out_manifest",
      "doc": "DRS manifest file in TSV format.",
      "label": "DRS manifest file in TSV format",
      "type": "File?",
      "outputBinding": {
        "glob": "*_DRS_manifest.tsv",
        "outputEval": "$(inheritMetadata(self, inputs.in_avro))"
      },
      "sbg:fileTypes": "TSV"
    },
    {
      "id": "out_metadata",
      "doc": "Metadata of the PFB file.",
      "label": "Metadata of the PFB file",
      "type": "File?",
      "outputBinding": {
        "glob": "*metadata.json",
        "outputEval": "$(inheritMetadata(self, inputs.in_avro))"
      },
      "sbg:fileTypes": "JSON"
    }
  ],
  "doc": "**PFB Unwrapper** is used to extract data from PFB (Portable Format for Bioinformatics) files to TSV and JSON format.\n\nA PFB file is special kind of AVRO file, suitable for capturing and reconstructing biomedical relational data. It contains a particular AVRO schema called the PFB schema that represents a relational database, along with the data in a single compact package [1].  \n\nCommon Sources of PFBs: \n* Gen3-BDC [2]\n* PIC-SURE BDC [3]\n\n\n**PFB Unwrapper** does the following actions on an input PFB file:\n\n* Extracts data from each node of the input PFB file into separate TSV files [4].\n* Fetches the metadata and the schema of the PFB file in JSON format. \n* Gathers all DRS (Data Repository Service) URIs present in the PFB file into a DRS manifest file [5].\n\n*A list of **all inputs and parameters** with corresponding descriptions can be found at the bottom of this page.*\n\n***Please note that any cloud infrastructure costs resulting from app and pipeline executions, including the use of public apps, are the sole responsibility of you as a user. To avoid excessive costs, please read the app description carefully and set the app parameters and execution settings accordingly.***\n\n\n### Common Use Cases\nThe tool **PFB Unwrapper** takes a single AVRO file as input and gives the following outputs:\n* **TSV files for all nodes in input PFB**: TSV files containing the details of each node present in the input PFB file.\n* **Schema of the PFB file**: Schema of the input PFB file in JSON format.\n* **DRS manifest file in TSV format**: A manifest file in TSV format containing all the DRS URIs.\n* **Metadata of the PFB file**: Metadata of the input PFB file in JSON format.\n\n\n\n### Changes Introduced by Seven Bridges\n* A custom python script has been added that fetches the DRS URIs in **DRS manifest file in TSV format** from all the TSV files generated in **TSV files for all nodes in input PFB**. It extracts the DRS URIs from the columns labelled 'ga4gh_drs_uri' or 'drs_uri'.\n\n### Common Issues and Important Notes\n* No common issues specific to the tool's execution on the Seven Bridges Platform have been detected.\n\n### Limitations\n* Only a few functionalities from the PyPFB package have been wrapped in this tool: to convert the input PFB file into TSV files and to fetch metadata and schema of the PFB file. \n\n### Performance Benchmarking\nThe execution time for extracting various data from an input PFB file of size 44 MB is several minutes on the AWS on-demand default instance; the price is negligible (~ 0.01$). Unless specified otherwise, the default instance used to run the tool **PFB Unwrapper** tool will be c4.2xlarge (AWS).\n\n\n*Cost can be significantly reduced by using **spot instances**. Visit the [knowledge center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*\n\n\n### Portability\n**PFB Unwrapper** tool was tested with cwltool version 3.1.20241217163858. The `in_avro` input was provided in the job.yaml file and used for testing.\n\n### References\n[1] [PyPFB GitHub](https://github.com/uc-cdis/pypfb/blob/master/docs/detailed_pfb_doc.md)\n[2] [Gen3-BDC](https://gen3.biodatacatalyst.nhlbi.nih.gov/)\n[3] [PIC-SURE BDC](https://picsure.biodatacatalyst.nhlbi.nih.gov/)\n[4] [PyPFB documentation ](https://docs.pedscommons.org/WorkingWithPFBfiles/)\n[5] [Data Repository Service (DRS) ](https://ga4gh.github.io/data-repository-service-schemas/preview/release/drs-1.2.0/docs/)",
  "label": "PFB Unwrapper HS",
  "arguments": [
    {
      "prefix": "",
      "shellQuote": false,
      "position": 0,
      "valueFrom": "${\n    var cmd = 'pfb to -i ' + inputs.in_avro.path + ' tsv '\n    var outdir = inputs.in_avro.nameroot+'_tsvs'\n    return cmd + outdir + ' && '\n}"
    },
    {
      "prefix": "",
      "shellQuote": false,
      "position": 0,
      "valueFrom": "${\n    var cmd = 'pfb show -i ' + inputs.in_avro.path + ' schema > ' \n    var schema = inputs.in_avro.nameroot + '_schema.json' \n    return cmd + schema + ' && '\n}"
    },
    {
      "prefix": "",
      "shellQuote": false,
      "position": 1,
      "valueFrom": "${\n    return 'python3 manifest.py ' + inputs.in_avro.nameroot+'_tsvs'\n}"
    },
    {
      "prefix": "",
      "shellQuote": false,
      "position": 0,
      "valueFrom": "${\n    var cmd = 'pfb show -i ' + inputs.in_avro.path + ' metadata > ' \n    var meta = inputs.in_avro.nameroot + '_metadata.json' \n    return cmd + meta + ' && '\n}"
    }
  ],
  "requirements": [
    {
      "class": "ShellCommandRequirement"
    },
    {
      "class": "LoadListingRequirement"
    },
    {
      "class": "ResourceRequirement",
      "ramMin": "${\n    var  memory = 1024\n    if(inputs.mem_per_job)\n        memory = inputs.mem_per_job\n    return memory\n}",
      "coresMin": "${\n    var cpus = 1\n    if (inputs.cpu_per_job)\n        cpus = inputs.cpu_per_job\n    return cpus\n}"
    },
    {
      "class": "DockerRequirement",
      "dockerPull": "images.sb.biodatacatalyst.nhlbi.nih.gov/anushuab/pypfb:0"
    },
    {
      "class": "InitialWorkDirRequirement",
      "listing": [
        {
          "entryname": "manifest.py",
          "entry": "# import required module\r\nimport pandas as pd\r\nimport os\r\nimport argparse\r\nimport sys\r\n# assign directory\r\n#directory = './tsvs/'\r\ndirectory =sys.argv[1]\r\noutfile = directory.split('_tsvs')[0] + '_DRS_manifest.tsv'\r\n\r\nfolder = sys.argv[3] # enum = {no, yes}\r\n\r\nmanifest = pd.DataFrame()\r\n\r\n# iterate over files in\r\n# that directory\r\nfor filename in os.listdir(directory):\r\n    f = os.path.join(directory, filename)\r\n    # checking if it is a file\r\n    if os.path.isfile(f):\r\n        print(f)\r\n        # read in file\r\n        df = pd.read_csv(f, sep='\\t')\r\n        \r\n        # check if ga4gh_drs_uri is a column in df.columns\r\n        if 'ga4gh_drs_uri' in df.columns:\r\n            df = df.rename(columns={'ga4gh_drs_uri': 'drs_uri'})\r\n            \r\n        if 'drs_uri' in df.columns:\r\n            if folder == 'no':\r\n                df = df[['drs_uri', 'file_name'] + [col for col in df.columns if col not in ['drs_uri', 'file_name']]]\r\n                df = df.rename(columns={'file_name': 'name'})\r\n            elif folder == 'yes':\r\n                if 'bucket_path' in df.columns and pd.api.types.is_string_dtype(df['bucket_path']):\r\n                    # Handle both single paths and list-style multiple paths\r\n                    def extract_first_path(path_str):\r\n                        # If it starts with '[', it's a list format - extract first path\r\n                        if path_str.startswith('['):\r\n                            # Remove leading \"['s3://\" or \"['gs://\" and extract until first \"'\"\r\n                            first_path = path_str.split(\"'\")[1]  # Get the first quoted string\r\n                            # Remove the protocol prefix (s3:// or gs://)\r\n                            return first_path.split('://', 1)[1] if '://' in first_path else first_path\r\n                        else:\r\n                            # Single path - just remove the protocol prefix\r\n                            return path_str.split('://', 1)[1] if '://' in path_str else path_str\r\n                    \r\n                    df = df.assign(name = df['bucket_path'].apply(extract_first_path))\r\n                    df = df[['drs_uri', 'name'] + [col for col in df.columns if col not in ['drs_uri', 'name']]]\r\n                else:\r\n                    print(\"No folder structure exists\")\r\n                    df = df[['drs_uri', 'file_name'] + [col for col in df.columns if col not in ['drs_uri', 'file_name']]]\r\n                    df = df.rename(columns={'file_name': 'name'})\r\n            \r\n                    \r\n            #concat to existing manifest\r\n            manifest = pd.concat([manifest, df], ignore_index=True)\r\n            \r\n        \r\n\r\nif len(manifest) > 0:\r\n    manifest.to_csv(outfile, sep=\"\\t\", index=False) ",
          "writable": false
        }
      ]
    },
    {
      "class": "InlineJavascriptRequirement",
      "expressionLib": [
        "\nvar setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!o2) {\n        return o1;\n    };\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n        for (var key in commonMetadata) {\n            if (!(key in example)) {\n                delete commonMetadata[key]\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n        if (o1.secondaryFiles) {\n            o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)\n        }\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n            if (o1[i].secondaryFiles) {\n                o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)\n            }\n        }\n    }\n    return o1;\n};"
      ]
    }
  ],
  "sbg:projectName": "NHLBI DMC Acceleration",
  "sbg:revisionsInfo": [
    {
      "sbg:revision": 0,
      "sbg:modifiedBy": "jrozowsky",
      "sbg:modifiedOn": 1745530446,
      "sbg:revisionNotes": "Copy of jrozowsky/testing-sandbox/pfb-unwrapper-hs/14"
    },
    {
      "sbg:revision": 1,
      "sbg:modifiedBy": "cfisher_gmail",
      "sbg:modifiedOn": 1763647517,
      "sbg:revisionNotes": "Updating handling of lists of file path locations"
    }
  ],
  "sbg:image_url": null,
  "sbg:toolkit": "PyPFB",
  "sbg:toolkitVersion": "0.5.18",
  "sbg:toolAuthor": "University of Chicago, Seven Bridges Genomics",
  "sbg:links": [
    {
      "id": "https://docs.pedscommons.org/WorkingWithPFBfiles/",
      "label": "Homepage"
    },
    {
      "id": "https://github.com/uc-cdis/pypfb",
      "label": "Source code"
    },
    {
      "id": "https://github.com/uc-cdis/pypfb/releases/tag/0.5.31",
      "label": "Download"
    },
    {
      "id": "https://doi.org/10.1371/journal.pcbi.1010944",
      "label": "Publication"
    },
    {
      "id": "https://github.com/uc-cdis/pypfb/blob/master/docs/detailed_pfb_doc.md",
      "label": "Documentation"
    }
  ],
  "sbg:categories": [
    "CWLtool Tested",
    "File Format Conversion"
  ],
  "sbg:license": "Apache-2.0 license",
  "sbg:expand_workflow": false,
  "sbg:appVersion": [
    "v1.2"
  ],
  "id": "https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/kbradfordrti/nhlbi-dmc-acceleration/pfb-unwrapper-hs/1/raw/",
  "sbg:id": "kbradfordrti/nhlbi-dmc-acceleration/pfb-unwrapper-hs/1",
  "sbg:revision": 1,
  "sbg:revisionNotes": "Updating handling of lists of file path locations",
  "sbg:modifiedOn": 1763647517,
  "sbg:modifiedBy": "cfisher_gmail",
  "sbg:createdOn": 1745530446,
  "sbg:createdBy": "jrozowsky",
  "sbg:project": "kbradfordrti/nhlbi-dmc-acceleration",
  "sbg:sbgMaintained": false,
  "sbg:validationErrors": [],
  "sbg:contributors": [
    "cfisher_gmail",
    "jrozowsky"
  ],
  "sbg:latestRevision": 1,
  "sbg:publisher": "sbg",
  "sbg:content_hash": "a8eda43bb4463121f913069e4ff21b910d5c5c03a0e507a9b9b3bb4bc4c8b672f",
  "sbg:workflowLanguage": "CWL"
}
