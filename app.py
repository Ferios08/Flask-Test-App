from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os

app = Flask(__name__)
db_user = os.environ.get("POSTGRES_USERNAME")
db_pass = os.environ.get("POSTGRES_PASSWORD")
db_host = os.environ.get("POSTGRES_HOST")
db_port = os.environ.get("POSTGRES_PORT")
db_name = os.environ.get("POSTGRES_DATABASE")
app.config["SQLALCHEMY_DATABASE_URI"] = f"postgresql+psycopg2://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}"
db = SQLAlchemy(app)
migrate = Migrate(app, db)


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True, nullable=False)
    email = db.Column(db.String)


@app.route("/-/healthy")
def healthy():
    return {}, 200


@app.route("/-/ready")
def ready():
    return {}, 200


@app.route("/user")
def user_list():
    cols = ['id', 'email', 'username']
    users = User.query.all()
    result = [{col: getattr(d, col) for col in cols} for d in users]
    return result, 200


@app.route("/user", methods=["POST"])
def user_create():
    user = User(
        username=request.json["username"],
        email=request.json["email"],
    )
    db.session.add(user)
    db.session.commit()
    return {'id': user.id}, 201
