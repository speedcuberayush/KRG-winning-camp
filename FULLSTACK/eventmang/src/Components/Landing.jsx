import React from "react";
import "./styles/Landing.css";
import Accordion from "./Landing/Accordian";
function Landing() {
  return (
    <div className="LandingContainer">
      <div className="LandingMain">
        <div className="LandingDivision">
          <div className="LandingTitle">
            <span>Spectra</span>Events
          </div>
          <p className="LandingSlogan">
            {" "}
            Crafting Memorable Moments, One Event at a Time
          </p>
          <p className="LandingPara">
            We specialize in transforming your visions into extraordinary
            events. Whether it’s a dazzling wedding, an electrifying party, or a
            refined corporate gathering, our passion lies in crafting
            unforgettable experiences. With meticulous attention to detail and a
            flair for creativity, we turn your dreams into magical moments that
            captivate and inspire. Let’s create something unforgettable
            together.
          </p>
          <div className="LandingBtn">
            <button className="LandingButton"> Login</button>
            <a href="#" className="menu__link">
              View more
            </a>
          </div>
        </div>
      </div>
      <div className="AcPart">
        <p className="FAQH"> FAQs..</p>
        <Accordion />
      </div>
    </div>
  );
}

export default Landing;
