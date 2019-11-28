from ontology_app.models import db

db.drop_all()
db.create_all()