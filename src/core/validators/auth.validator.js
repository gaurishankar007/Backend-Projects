import { emailRegex, passwordRegex } from "../constants/regex.js";

const authValidator = {
  register: (json) => {
    const { firstName, lastName, email, password } = json;

    if (firstName === undefined || firstName.trim() === "") {
      return "First name is required";
    } else if (lastName === undefined || lastName.trim() === "") {
      return "Last name is required";
    } else if (email === undefined || email.trim() === "") {
      return "Email is required";
    } else if (!emailRegex.test(email)) {
      return "Invalid email";
    } else if (password === undefined || password.trim() === "") {
      return "Password is required";
    } else if (!passwordRegex.test(password)) {
      return "Password must have at least 1 uppercase, lowercase, numeric digit, and length from 5 to 15";
    }

    return undefined;
  },
  login: (json) => {
    const { email, password } = json;

    if (email === undefined || email.trim() === "") {
      return "Email is required";
    } else if (password === undefined || password.trim() === "") {
      return "Password is required";
    }

    return undefined;
  },
};

export default authValidator;
