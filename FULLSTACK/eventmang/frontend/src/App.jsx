import "./App.css";
import { BrowserRouter } from "react-router-dom";
import { Route, Routes } from "react-router-dom";
import Landing from "./Components/Landing";
import Authentication from "./Components/Authentication/Authentication";
import Student from "./Components/Pages/Student/Student";

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Routes>
          <Route exact path="/" element={<Landing />} />
          <Route path="/authentication" element={<Authentication />} />
          <Route path="/feed" element={<Student />} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
