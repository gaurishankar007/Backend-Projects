import { emailRegex, passwordRegex } from "../constants/regex.js";

const authValidator = {
  register: (json) => {
    const { firstName, lastName, email, password } = json;

    if (firstName === undefined || firstName.trim() === "")
      return "First name is required";
    if (lastName === undefined || lastName.trim() === "")
      return "Last name is required";
    if (email === undefined || email.trim() === "") return "Email is required";
    if (!emailRegex.test(email)) return "Invalid email";
    if (password === undefined || password.trim() === "")
      return "Password is required";
    if (!passwordRegex.test(password))
      return "Password must have 5 to 15 char and at least 1 uppercase, lowercase, numeric digit";

    return undefined;
  },
  login: (json) => {
    const { email, password } = json;

    if (email === undefined || email.trim() === "") return "Email is required";
    if (password === undefined || password.trim() === "")
      return "Password is required";

    return undefined;
  },
  changePassword: (json) => {
    const { oldPassword, password, confirmPassword } = json;

    if (!oldPassword || oldPassword.trim() === "")
      return "Old password is required";
    if (!password || password.trim() === "") return "Password is required";
    if (!confirmPassword || confirmPassword.trim() === "")
      return "Confirm password is required";
    if (password !== confirmPassword)
      return "Password and confirm password did not match";

    return undefined;
  },
};

export default authValidator;
