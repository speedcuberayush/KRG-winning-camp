import React from "react";
import "./Post.css";

function Post({ title = "TITLE", by = "by", role = "role" }) {
  return (
    <div className="postContent">
      <img
        src="https://cdn.leonardo.ai/users/a0e3d238-9331-4629-8e65-7dd741edb548/generations/97915906-2ae4-4b17-af14-7bc29d83e369/Default_students_hackethon_1.jpg"
        alt=""
      />
      <div className="overlay">{title}</div>
      <div className="postCnn">
        <div className="PostContenttext">
          <p>{by}</p>
          <p>{role}</p>
        </div>
        <button className="shadow__btn">Apply</button>
      </div>
    </div>
  );
}

export default Post;
