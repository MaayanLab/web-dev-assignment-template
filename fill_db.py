from ontology_app.models import db, Term
import csv

##############################################################
# Parse an ontology csv file and save 
# (1) class_id 
# (2) preferred_label
# (3) term (taken from the synonyms and the preferred label)
# to the database
##############################################################
