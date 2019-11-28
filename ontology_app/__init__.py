from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
import requests as api_requests # Alias
import json

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////tmp/ontology.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Import models
from .models import Term

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/ontology_search', methods=['GET','POST'])
@app.route('/ontology_search/<string:term>')
def ontology_search(term=None):
    # Fill this out