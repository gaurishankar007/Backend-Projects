const successResponse = (
  res: any,
  data: any,
  status = true,
  statusCode = 200
) => res.status(statusCode).json({ status, data });

const errorResponse = (
  res: any,
  error: any,
  status = false,
  statusCode = 400
) => res.status(statusCode).json({ status, error });

export { errorResponse, successResponse };
