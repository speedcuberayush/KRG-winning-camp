import React from "react";
import "./Feed.scss";
import Sidebar from "./Sidebar";
import Content from "./Content";
import Right from "./Right";
function Feed() {
  return (
    <div className="Feed">
      <Sidebar />
      <Explore />
    </div>
  );
}

export default Feed;

function Explore() {
  return (
    <div className="FeedPP">
      <div className="LandingTitle">
        <span>Spectra</span>Events
      </div>
      <div className="FeedPart">
        <Content />
        <Right />
      </div>
    </div>
  );
}
