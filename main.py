from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
import math

# reading the config.json file
with open("config.json", "r") as c:
    params = json.load(c)["params"]

local_server = True
app = Flask(__name__)
# used for making session
app.secret_key = "super-secret-key"
# target=_blank means that open the link in new page

if local_server:
    app.config["SQLALCHEMY_DATABASE_URI"] = params["local_uri"]
else:
    app.config["SQLALCHEMY_DATABASE_URI"] = params["prod_uri"]
db = SQLAlchemy(app)


# keep name of class starting from capital letter
class Contacts(db.Model):
    # sno name email phone_num message date
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    email = db.Column(db.String(50), unique=False, nullable=False)
    phone_num = db.Column(db.String(20), unique=False, nullable=False)
    message = db.Column(db.Text, unique=False, nullable=False)
    date = db.Column(db.String(20), unique=False, nullable=True)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), unique=False, nullable=False)
    content = db.Column(db.String(500), unique=False, nullable=False)
    slug = db.Column(db.String(30), unique=False, nullable=False)
    date = db.Column(db.String(20), unique=False, nullable=True)
    img_file = db.Column(db.String(20), unique=False, nullable=True)


@app.route("/")
def home():
    # pass params into the index.html file for rendering
    posts = Posts.query.filter_by().all()
    n = int(params["no_of_posts"])
    last = math.ceil(len(posts) / n)
    page = request.args.get("page")
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    posts = posts[(page - 1) * n : (page - 1) * n + n]

    if page == 1:
        prev = "#"
        next = "/?page=" + str(page + 1)
    elif page == last:
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template(
        "index.html", params=params, posts=posts, prev=prev, next=next
    )


@app.route("/about.html")
def about():
    return render_template("about.html", params=params)


# whatever comes after post.html/ is considered as slug of type string
@app.route("/post.html/<string:post_slug>", methods=["GET"])
def post_route(post_slug):
    # get the first post that has matching slug with the post_slug
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html", params=params, post=post)


@app.route("/contact.html", methods=["GET", "POST"])
def contact():
    if request.method == "POST":
        # add entry to the database
        name = request.form.get("name")
        email = request.form.get("email")
        phone_no = request.form.get("phone_num")
        msg = request.form.get("message")

        entry = Contacts(
            name=name, email=email, phone_num=phone_no, message=msg, date=datetime.now()
        )
        with db.session.begin():
            db.session.add(entry)
            db.session.commit()
    return render_template("/contact.html", params=params)


@app.route("/dashboard.html", methods=["GET", "POST"])
def admin():
    # create secret key before creating session
    if "user" in session and session["user"] == params["admin-user"]:
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)

    if request.method == "POST":
        # redirect to admin portal
        username = request.form.get("username")
        password = request.form.get("password")
        if username == params["admin-user"] and password == params["admin-pass"]:
            session["user"] = username
            # set the session variable
            posts = Posts.query.all()
            return render_template("dashboard.html", params=params, posts=posts)
        else:
            return render_template("signIn.html", params=params)
    else:
        return render_template("signIn.html", params=params)


@app.route("/edit/<int:sn>", methods=["GET", "POST"])
def edit(sn):
    # admin already logged in
    if "user" in session and session["user"] == params["admin-user"]:
        if request.method == "POST":
            edit_title = request.form.get("title")
            edit_content = request.form.get("content")
            edit_slug = request.form.get("slug")

            if sn == 0:
                # this is for adding new posts in the db
                post = Posts(
                    title=edit_title,
                    content=edit_content,
                    slug=edit_slug,
                    date=datetime.now(),
                )
                with db.session.begin():
                    db.session.add(post)
                    db.session.commit()

            else:
                post = Posts.query.filter_by(sno=sn).first()
                post.title = edit_title
                post.content = edit_content
                post.slug = edit_slug
                db.session.commit()

            return redirect("/dashboard.html")
            # updating the posts

        post = Posts.query.filter_by(sno=sn).first()

        # edit.html file is called when we get a request to edit a post
        # post is passed to edit post and sno for the case when we want to add a new post
        return render_template("edit.html", post=post, sno=sn)


@app.route("/delete/<int:sn>")
def delete(sn):
    # If the admin is already logged in
    if "user" in session and session["user"] == params["admin-user"]:
        post = Posts.query.filter_by(sno=sn).first()
        db.session.delete(post)
        db.session.commit()

    # if the admin is logged in dashboard will be shown which will redirect to the sign in page
    return redirect("/dashboard.html")


@app.route("/logout")
def logout():
    session.pop("user")
    return redirect("/dashboard.html")


app.run(debug=True)


# To access the admin dashboard, use localhost/dashboard.html
