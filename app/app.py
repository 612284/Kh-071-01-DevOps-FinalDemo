from flask import Flask, render_template
import random
app = Flask(__name__)
# list of cat images
images = [
"https://i.picsum.photos/id/1/500/500.jpg?hmac=6vo7WkHURh9CWfdf144ASqEaPNcbj2PHJK3UgGH24lM",
"https://i.picsum.photos/id/165/500/500.jpg?hmac=n0Bj1mlvxokLZkMjvB0SQpeW6P_RocF_AzhVrLQKYGE",
"https://i.picsum.photos/id/984/500/500.jpg?hmac=pyY7pQAMjNdqpFpf7EGBwLWshfW7o1ql2QIDKdwBNAU",
"https://i.picsum.photos/id/731/500/500.jpg?hmac=ZTiJtvtdZXLuuNDzZvSa3n4E-6DEBAQe2qTbEE8eZxw",
"https://i.picsum.photos/id/861/500/500.jpg?hmac=r0X8208-EpZTr3l4mQLjt0EHu3BzUqLpbGeaaK7gdlE"
]
@app.route('/')
def index():
 url = random.choice(images)
 return render_template('index.html', url = url)
if __name__ == "__main__":
 app.run(host = "0.0.0.0")
