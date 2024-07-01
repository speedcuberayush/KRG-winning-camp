import * as React from "react";
import "./Accordion.css";
import { styled } from "@mui/material/styles";
import ArrowForwardIosSharpIcon from "@mui/icons-material/ArrowForwardIosSharp";
import MuiAccordion from "@mui/material/Accordion";
import MuiAccordionSummary from "@mui/material/AccordionSummary";
import MuiAccordionDetails from "@mui/material/AccordionDetails";
import Typography from "@mui/material/Typography";

const Accordion = styled((props) => (
  <MuiAccordion disableGutters elevation={0} square {...props} />
))(({ theme }) => ({
  border: `1px solid #2f2f2e`, // Dark gray border
  "&:not(:last-child)": {
    borderBottom: 0,
  },
  "&::before": {
    display: "none",
  },
}));

const AccordionSummary = styled((props) => (
  <MuiAccordionSummary
    expandIcon={
      <ArrowForwardIosSharpIcon sx={{ fontSize: "0.9rem", color: "#fff" }} />
    }
    {...props}
  />
))(({ theme }) => ({
  color: "#fff", // White text color
  backgroundColor: "#2f2f2e", // Dark gray background color
  flexDirection: "row-reverse",
  "& .MuiAccordionSummary-expandIconWrapper.Mui-expanded": {
    transform: "rotate(90deg)",
  },
  "& .MuiAccordionSummary-content": {
    marginLeft: theme.spacing(1),
  },
}));

const AccordionDetails = styled(MuiAccordionDetails)(({ theme }) => ({
  padding: theme.spacing(2),
  borderTop: "1px solid #fff", // White with opacity
  backgroundColor: "#2f2f2e", // Dark gray background color
  color: "#fff", // White text color
}));
export default function CustomizedAccordions() {
  const [expanded, setExpanded] = React.useState("panel1");

  const handleChange = (panel) => (event, newExpanded) => {
    setExpanded(newExpanded ? panel : false);
  };

  return (
    <div className="AccordianL">
      <Accordion
        expanded={expanded === "panel1"}
        onChange={handleChange("panel1")}
      >
        <AccordionSummary aria-controls="panel1d-content" id="panel1d-header">
          <Typography> What types of events do you specialize in?</Typography>
        </AccordionSummary>
        <AccordionDetails style={{ padding: "1.5em" }}>
          <Typography>
            We specialize in a wide range of events including weddings,
            corporate gatherings, private parties, conferences, and more. Our
            expertise spans from intimate celebrations to large-scale
            productions, ensuring each event is tailored to perfection.
          </Typography>
        </AccordionDetails>
      </Accordion>
      <Accordion
        expanded={expanded === "panel2"}
        onChange={handleChange("panel2")}
      >
        <AccordionSummary aria-controls="panel2d-content" id="panel2d-header">
          <Typography>
            How do you ensure the quality of your services?
          </Typography>
        </AccordionSummary>
        <AccordionDetails style={{ padding: "1.5em" }}>
          <Typography>
            Quality is at the heart of everything we do. We meticulously plan
            every detail, collaborate with top vendors, and maintain clear
            communication with our clients throughout the entire process. Our
            goal is to exceed expectations and deliver memorable experiences.
          </Typography>
        </AccordionDetails>
      </Accordion>
      <Accordion
        expanded={expanded === "panel3"}
        onChange={handleChange("panel3")}
      >
        <AccordionSummary aria-controls="panel3d-content" id="panel3d-header">
          <Typography>
            Can you assist with event planning from start to finish?
          </Typography>
        </AccordionSummary>
        <AccordionDetails style={{ padding: "1.5em" }}>
          <Typography>
            Absolutely! From initial concept development to final execution, we
            offer comprehensive event planning services. This includes venue
            selection, theme development, catering, décor, entertainment, and
            more. We handle all aspects so you can relax and enjoy your event.
          </Typography>
        </AccordionDetails>
      </Accordion>
      <Accordion
        expanded={expanded === "panel4"}
        onChange={handleChange("panel4")}
      >
        <AccordionSummary aria-controls="panel4d-content" id="panel4d-header">
          <Typography>
            How far in advance should I book your services?
          </Typography>
        </AccordionSummary>
        <AccordionDetails style={{ padding: "1.5em" }}>
          <Typography>
            We recommend booking as early as possible to secure your preferred
            date and ensure ample time for planning. However, we understand
            last-minute needs and can accommodate shorter timelines whenever
            feasible. Contact us to discuss your specific event requirements and
            timeline.
          </Typography>
        </AccordionDetails>
      </Accordion>
    </div>
  );
}
