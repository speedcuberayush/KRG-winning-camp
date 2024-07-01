import React from "react";
import { NavLink } from "react-router-dom";
import { IconButton } from "@mui/material";
import {
  AccountCircle,
  ExitToApp,
  Explore,
  Settings,
} from "@mui/icons-material";

function Sidebar() {
  const buttonStyle = {
    fontSize: "2rem",
    padding: "12px",
  };

  return (
    <div className="sideBar">
      <NavLink
        to="/feed"
        style={({ isActive }) => ({
          color: "inherit", // Ensure NavLink itself does not override icon color
        })}
      >
        {({ isActive }) => (
          <IconButton
            style={{ ...buttonStyle, color: isActive ? "#0096ff" : "#fff" }}
          >
            <Explore style={{ fontSize: "inherit" }} />
          </IconButton>
        )}
      </NavLink>
      <NavLink
        to="/auth"
        style={({ isActive }) => ({
          color: "inherit", // Ensure NavLink itself does not override icon color
        })}
      >
        {({ isActive }) => (
          <IconButton
            style={{ ...buttonStyle, color: isActive ? "#0096ff" : "#fff" }}
          >
            <AccountCircle style={{ fontSize: "inherit" }} />
          </IconButton>
        )}
      </NavLink>
      <NavLink
        to="/settings"
        style={({ isActive }) => ({
          color: "inherit", // Ensure NavLink itself does not override icon color
        })}
      >
        {({ isActive }) => (
          <IconButton
            style={{ ...buttonStyle, color: isActive ? "#0096ff" : "#fff" }}
          >
            <Settings style={{ fontSize: "inherit" }} />
          </IconButton>
        )}
      </NavLink>
      <NavLink
        to="/"
        style={({ isActive }) => ({
          color: "inherit", // Ensure NavLink itself does not override icon color
        })}
      >
        {({ isActive }) => (
          <IconButton
            style={{ ...buttonStyle, color: isActive ? "#0096ff" : "#fff" }}
          >
            <ExitToApp style={{ fontSize: "inherit" }} />
          </IconButton>
        )}
      </NavLink>
    </div>
  );
}

export default Sidebar;
