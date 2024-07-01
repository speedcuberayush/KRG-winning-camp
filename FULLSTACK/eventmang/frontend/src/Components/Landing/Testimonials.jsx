import "./Testimonials.scss";
import React, { useState } from "react";

function Testimonials() {
  const [activeTestimonialsCard, setActiveTestimonialsCard] =
    useState("TestiContent1");

  const handleTestimonialsCardMouseOver = (TestimonialsCardId) => {
    setActiveTestimonialsCard(TestimonialsCardId);
  };

  return (
    <div className="TestiContainer">
      <div className="TestimonialsTestimonial">
        <section className="TestimonialsTesti">
          <h1 className="TestiHeader1">testimonials</h1>
          <div className="TestimonialsCards">
            <div
              className={`TestimonialsCard ${
                activeTestimonialsCard === "TestiContent1" ? "active" : ""
              }`}
              data-id="TestiContent1"
              onMouseOver={() =>
                handleTestimonialsCardMouseOver("TestiContent1")
              }
            >
              <img
                className="Tesitimg"
                src="https://apidyn.royalsociety.org/images/fellows/P37009-Elon-Musk.jpg"
                alt=""
              />
              <div>
                <h3 className="TestiHeader3">ELON MUSK</h3>
                <p className="TestiPara">CEO, SpaceX and Tesla</p>
              </div>
              <div className="gradient" />
              {/* ... (Rest of the TestimonialsCard TestiContent) */}
            </div>
            <div
              className={`TestimonialsCard ${
                activeTestimonialsCard === "TestiContent2" ? "active" : ""
              }`}
              data-id="TestiContent2"
              onMouseOver={() =>
                handleTestimonialsCardMouseOver("TestiContent2")
              }
            >
              <img
                className="Tesitimg"
                src="https://pbs.twimg.com/profile_images/1383660243587002368/DJQEGX2o_400x400.jpg"
                alt=""
              />
              <div>
                <h3 className="TestiHeader3">Sandeep Jain</h3>
                <p className="TestiPara"> Founder and CEO of GeeksforGeeks</p>
              </div>
              <div className="gradient" />
              {/* ... (Rest of the TestimonialsCard TestiContent) */}
            </div>
            <div
              className={`TestimonialsCard ${
                activeTestimonialsCard === "TestiContent3" ? "active" : ""
              }`}
              data-id="TestiContent3"
              onMouseOver={() =>
                handleTestimonialsCardMouseOver("TestiContent3")
              }
            >
              {/* ... (Rest of the TestimonialsCard TestiContent) */}
              <img
                className="Tesitimg"
                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw7XEjwYa9WAkePZbthPOKp6-D4ZjRzopAqOCfamH3hU1bAG53RBjkKdgimcj0uKyt7pg&usqp=CAU"
                alt=""
              />
              <div>
                <h3 className="TestiHeader3">Narendra Modi</h3>
                <p className="TestiPara">Prime Minister of India</p>
              </div>
              <div className="gradient" />
            </div>
          </div>
          <div className="TestiContent">
            <div
              className={`TestiContentBox ${
                activeTestimonialsCard === "TestiContent1" ? "active" : ""
              }`}
              id="TestiContent1"
            >
              {/* ... (TestiContent for TestiContent1) */}
              <div className="TestimonialsTxet">
                <h2 className="TestiHeader2">Great Innovation</h2>
                <span className="TestiSppan">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                </span>
                <p className="TestiPara">
                  Attending an event orchestrated by SpectraEvents was an
                  extraordinary experience. Their ability to seamlessly blend
                  cutting-edge innovation with impeccable execution is truly out
                  of this world.
                </p>

                <p className="TestiPara">
                  The team’s precision and attention to detail are akin to the
                  rigorous standards we uphold at SpaceX and Tesla. They don't
                  just manage events; they engineer them, turning visions into
                  experiences that defy expectations.
                </p>

                <p className="TestiPara">
                  What struck me most was their commitment to pushing the
                  boundaries of what’s possible in event planning. It’s clear
                  that they operate with the same pioneering spirit and
                  relentless drive for perfection that I value.
                </p>
                <p className="TestiPara">
                  SpectraEvents is setting a new standard in the industry. If
                  you're looking for an event that’s not just memorable but
                  truly remarkable, these are the people to call. They’ve got
                  the innovation and the execution dialed in.
                </p>
              </div>
            </div>
            <div
              className={`TestiContentBox ${
                activeTestimonialsCard === "TestiContent2" ? "active" : ""
              }`}
              id="TestiContent2"
            >
              {/* ... (TestiContent for TestiContent2) */}
              <div className="TestimonialsTxet">
                <h2 className="TestiHeader2">It was a great experience!</h2>
                <span className="TestiSppan">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                </span>
                <p className="TestiPara">
                  Partnering with SpectraEvents for our recent event was a
                  game-changer. Their expertise in planning and execution is
                  akin to writing the perfect code – seamless, efficient, and
                  remarkably effective.
                </p>
                <p className="TestiPara"></p>
                <p className="TestiPara">
                  As the founder of GeeksforGeeks, I value precision and
                  innovation, and that’s exactly what they delivered. Their team
                  approached the event with the same level of dedication and
                  attention to detail that we apply to our platform. Every
                  element, from the venue setup to the program flow, was
                  executed flawlessly, creating an environment that was both
                  engaging and inspiring.
                </p>
                <p className="TestiPara">
                  What stood out the most was their ability to integrate the
                  latest trends and technology into the event, ensuring a modern
                  and dynamic experience for all our attendees. It was like
                  witnessing the fusion of creativity with structured
                  problem-solving, resulting in an event that truly stood out.
                </p>
                <p className="TestiPara">
                  For anyone looking to elevate their events with meticulous
                  planning and innovative flair, SpectraEvents is the perfect
                  partner. They’ve set a new benchmark for event management,
                  much like we strive to do in the coding world.
                </p>
              </div>
            </div>
            <div
              className={`TestiContentBox ${
                activeTestimonialsCard === "TestiContent3" ? "active" : ""
              }`}
              id="TestiContent3"
            >
              {/* ... (TestiContent for TestiContent3) */}
              <div className="TestimonialsTxet">
                <h2 className="TestiHeader2">
                  {" "}
                  A transformative educational initiative that aligns perfectly
                  with his vision for digital India.
                </h2>
                <span className="TestiSppan">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="currentColor"
                    className="w-6 h-6"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"
                      clipRule="evenodd"
                    />
                  </svg>
                </span>
                <p className="TestiPara">
                  I had the pleasure of attending an event organized by
                  SpectraEvents, and I must commend the team for their
                  exceptional dedication and professionalism. The event was a
                  true testament to their ability to blend tradition with
                  innovation, creating a vibrant and unforgettable experience.
                  From the seamless coordination to the meticulous attention to
                  detail, every aspect was handled with utmost care. The
                  ambiance reflected the spirit of our rich heritage while
                  embracing the contemporary, showcasing their ability to honor
                  the past and embrace the future.
                </p>
                <p className="TestiPara">
                  Their commitment to excellence is truly commendable. I am
                  confident that SpectraEvents will continue to set new
                  standards in event management, delivering remarkable
                  experiences that resonate with all who attend. I extend my
                  best wishes to the team for their continued success.
                </p>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}

export default Testimonials;
