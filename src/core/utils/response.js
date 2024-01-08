const successRes = (res, data, message = "Success", statusCode = 200) =>
  res.status(statusCode).json({
    message,
    data,
  });

const errorRes = (res, error, message = "Failure", statusCode = 400) =>
  res.status(statusCode).json({
    message,
    error,
  });

export { errorRes, successRes };
