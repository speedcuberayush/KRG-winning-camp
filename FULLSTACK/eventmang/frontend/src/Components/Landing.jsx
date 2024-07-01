import React from "react";
import "./styles/Landing.css";
import Accordion from "./Landing/Accordian";
import Gallery from "./Landing/Gallery";
import Testimonials from "./Landing/Testimonials";
import PartnerContainer from "./Landing/PartnerContainer";
import { Link, NavLink } from "react-router-dom";
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
            <NavLink to="/authentication">
              <button className="LandingButton"> Login</button>
            </NavLink>

            <Link href="#LandingAboutus" className="menu__link">
              View more
            </Link>
          </div>
        </div>
      </div>
      <div id="LandingAboutus" className="LandingAboutus">
        <div className="notification">
          <div className="notiglow" />
          <div className="notiborderglow" />
          <div className="notititle">About Us: Your Vision, Our Craft</div>
          <div className="notibody">
            <p>
              We believe that every event tells a unique story, and we are
              passionate about making yours extraordinary. Founded with a vision
              to elevate the art of celebration, we combine creativity,
              precision, and a personal touch to bring your dreams to life.
            </p>
            <p>
              Our team is a dynamic blend of experienced planners, innovative
              designers, and meticulous coordinators who thrive on turning ideas
              into reality. We specialize in creating bespoke events that
              reflect your individuality and style, whether it’s a romantic
              wedding, a chic corporate event, or a lively social gathering.
            </p>
            <p>
              With a keen eye for detail and a commitment to excellence, we
              handle every aspect of your event with the utmost care. From the
              initial consultation to the final flourish, we ensure a seamless
              and stress-free experience, allowing you to fully enjoy every
              moment.
            </p>

            <p>
              Driven by a passion for perfection, we take pride in crafting
              events that leave a lasting impression. At [Your Website Name], we
              don’t just plan events; we curate experiences that inspire and
              delight. Join us on a journey where your vision meets our craft,
              and together, let’s create something truly magical.
            </p>
          </div>
        </div>
      </div>
      <div className="PartnerContainerss">
        <p className="PCTEXT">OUR PARTNERS</p>
        <PartnerContainer />
      </div>
      <div className="LandingImageSection">
        <p className="LISTEXT">PAST WORKS</p>
        <Gallery />
      </div>
      <Testimonials />
      <div className="AcPart">
        <p className="FAQH"> FAQs..</p>
        <Accordion />
      </div>
    </div>
  );
}

export default Landing;
