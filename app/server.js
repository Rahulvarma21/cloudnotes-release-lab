const express = require("express");

const app = express();
const PORT = process.env.PORT || 8080;
const API_KEY = process.env.API_KEY || "";

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "ok",
    service: "cloudnotes-api",
    version: "0.1.0",
    apiKeyConfigured: Boolean(API_KEY),
  });
});

app.get("/", (req, res) => {
  res.status(200).send("cloudnotes-api is running. See /health for status.");
});

app.listen(PORT, () => {
  console.log(`cloudnotes-api listening on port ${PORT}`);
});
