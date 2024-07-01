import React from "react";
import "./Right.css";
function Right() {
  return (
    <div className="Right">
      <Cardss />
      <Cardss />
      <Cardss />
      <Cardss />
      <Cardss />
    </div>
  );
}

export default Right;

function Cardss({ title = "event name ", desc = "role provided" }) {
  return (
    <div className="N1notification">
      <div className="N1notiglow" />
      <div className="N1notiborderglow" />
      <div className="N1notititle">{title}</div>
      <div className="N1notibody">
        <div
          style={{
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
          }}
        >
          <p>{desc}</p>
          <button class="Cbtncards">view</button>
        </div>
      </div>
    </div>
  );
}
