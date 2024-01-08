const successRes = (res, message = "Success", data, statusCode = 200) =>
  res.status(statusCode).json({
    message,
    data,
  });

const errorRes = (res, message = "Failure", error, statusCode = 400) =>
  res.status(statusCode).json({
    message,
    error,
  });

export { errorRes, successRes };
