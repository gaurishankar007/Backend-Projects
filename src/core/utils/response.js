const successResponse = (res, data, status = true, statusCode = 200) =>
  res.status(statusCode).json({
    status,
    data,
  });

const errorResponse = (res, error, status = false, statusCode = 400) =>
  res.status(statusCode).json({
    status,
    error,
  });

export { errorResponse, successResponse };
