const successRes = (res, data, status = true, statusCode = 200) =>
  res.status(statusCode).json({
    status,
    data,
  });

const errorRes = (res, error, status = false, statusCode = 400) =>
  res.status(statusCode).json({
    status,
    error,
  });

export { errorRes, successRes };
