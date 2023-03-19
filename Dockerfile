# Build Phase
FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# Run Phase
FROM nginx

# Copy something a difference phase, in this case is the build phase
COPY --from=builder /app/build /usr/share/nginx/html

# Nginx docker image automatically runs the start comamand hence we dont need any run command for nginx