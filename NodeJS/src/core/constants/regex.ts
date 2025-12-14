const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,15}$/;

const emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

const nameRegex = /^[a-zA-Z\s]*$/;

export { passwordRegex, emailRegex, nameRegex };
