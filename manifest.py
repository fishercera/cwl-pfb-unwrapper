# import required module
import pandas as pd
import os
import argparse
import sys
# assign directory
#directory = './tsvs/'
directory =sys.argv[1]
# Getting the name of the DRS manifest file from the directory name
outfile = directory.split('_tsvs')[0] + '_DRS_manifest.tsv'

folder = sys.argv[3] # enum = {no, yes}

manifest = pd.DataFrame()

# iterate over files in
# that directory; every time we encounter a DRS URI 
# we want to add it to the DRS Manifest 
for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    # checking if it is a file
    if os.path.isfile(f):
        print(f)
        # read in file
        df = pd.read_csv(f, sep='\t')
        
        # check if ga4gh_drs_uri is a column in df.columns
        if 'ga4gh_drs_uri' in df.columns:
            # If it is, rename it to drs_uri, because the column name MUST be drs_uri
            df = df.rename(columns={'ga4gh_drs_uri': 'drs_uri'})
            
        if 'drs_uri' in df.columns:
            if folder == 'no': # User opted not to save folder structure
                df = df[['drs_uri', 'file_name'] + [col for col in df.columns if col not in ['drs_uri', 'file_name']]]
                df = df.rename(columns={'file_name': 'name'})
            elif folder == 'yes':
                if 'bucket_path' in df.columns and pd.api.types.is_string_dtype(df['bucket_path']):
                    # Handle both single paths and list-style multiple paths
                    def extract_first_path(path_str):
                        # If it starts with '[', it's a list format - extract first path
                        if path_str.startswith('['):
                            #### This part is risky/fragile; there's nothing that guarantees that the s3 bucket_path will come first, 
                            #### And there is nothing that guarantees that the google cloud and s3 bucket paths will be the same. 
                            #### Might be best to choose s3 if available, and only take gs if s3 is not available. 
                            # Remove leading "['s3://" or "['gs://" and extract until first "'"
                            first_path = path_str.split("'")[1]  # Get the first quoted string
                            # Remove the protocol prefix (s3:// or gs://)
                            return first_path.split('://', 1)[1] if '://' in first_path else first_path
                        else:
                            # Single path - just remove the protocol prefix
                            return path_str.split('://', 1)[1] if '://' in path_str else path_str
                    
                    df = df.assign(name = df['bucket_path'].apply(extract_first_path))
                    df = df[['drs_uri', 'name'] + [col for col in df.columns if col not in ['drs_uri', 'name']]]
                else:
                    print("No folder structure exists")
                    df = df[['drs_uri', 'file_name'] + [col for col in df.columns if col not in ['drs_uri', 'file_name']]]
                    df = df.rename(columns={'file_name': 'name'})
            
                    
            #concat to existing manifest
            manifest = pd.concat([manifest, df], ignore_index=True)
            
        

##### Now from the manifest dataframe create the DRS manifest file and write it out. 

if len(manifest) > 0:
    manifest.to_csv(outfile, sep="\t", index=False) 
