import { ConnectionOptions } from 'mysql2/promise';
import '../../envConfig'

const databaseCredentials: ConnectionOptions = {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_USER_PASSWORD,
  database: process.env.DB_NAME
};

export { databaseCredentials }
