

library(httr2)

call_chatgpt <- function(prompt) {
  api_key <- Sys.getenv("OPENAI_API_KEY")
  if (identical(api_key, "")) stop("Missing OPENAI_API_KEY env var")

  req <- request("https://api.openai.com/v1/responses") |>
    req_headers(
      Authorization = paste("Bearer", api_key),
      "Content-Type" = "application/json"
    ) |>
    req_body_json(list(
      model = "gpt-4.1-mini",
      input = prompt
    ))

  resp <- req_perform(req)
  resp_body_json(resp)$output_text
}
