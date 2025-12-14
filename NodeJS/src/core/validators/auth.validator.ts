import { emailRegex, nameRegex, passwordRegex } from "../constants/regex.js";

const authValidator = {
  register: (json: any) => {
    const { name, email, password } = json;

    if (name === undefined || name.trim() === "") return "Name is required";
    if (!nameRegex.test(name)) return "Invalid name";
    if (name.length <= 3) return "Name is too short";
    if (email === undefined || email.trim() === "") return "Email is required";
    if (!emailRegex.test(email)) return "Invalid email";
    if (password === undefined || password.trim() === "")
      return "Password is required";
    if (!passwordRegex.test(password))
      return "Password must have 5 to 15 char and at least 1 uppercase, lowercase, numeric digit";

    return undefined;
  },
  login: (json: any) => {
    const { email, password } = json;

    if (email === undefined || email.trim() === "") return "Email is required";
    if (password === undefined || password.trim() === "")
      return "Password is required";

    return undefined;
  },
  changePassword: (json: any) => {
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
