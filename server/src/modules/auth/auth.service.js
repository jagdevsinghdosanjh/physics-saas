import prisma from "../../prisma/client.js";
import { hashPassword, comparePassword } from "../../utils/hash.js";
import { generateAccessToken, generateRefreshToken } from "../../utils/jwt.js";

export const registerUser = async (data) => {
  const existing = await prisma.users.findUnique({
    where: { email: data.email },
  });

  if (existing) throw new Error("Email already registered");

  const hashed = await hashPassword(data.password);

  const user = await prisma.users.create({
    data: {
      name: data.name,
      email: data.email,
      password: hashed,
      role: "student",
    },
  });

  return user;
};

export const loginUser = async (email, password) => {
  const user = await prisma.users.findUnique({ where: { email } });

  if (!user) throw new Error("Invalid credentials");

  const match = await comparePassword(password, user.password);
  if (!match) throw new Error("Invalid credentials");

  const accessToken = generateAccessToken(user);
  const refreshToken = generateRefreshToken(user);

  await prisma.refresh_tokens.create({
    data: {
      user_id: user.id,
      token: refreshToken,
    },
  });

  return { user, accessToken, refreshToken };
};
