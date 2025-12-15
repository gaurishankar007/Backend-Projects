export const successResponse = (res: any, data: any, statusCode = 200) => {
  if (statusCode === 204) return res.status(statusCode).send();
  res.status(statusCode).json({
    status: true,
    data: data,
  });
};

export const errorResponse = (
  res: any,
  error: any = "Internal Server Error",
  data: any = undefined,
  statusCode = 500
) => {
  res.status(statusCode).json({
    status: false,
    error: error,
    data: data,
  });
};
