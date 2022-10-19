FROM debian:stable-slim 

RUN apt-get update
RUN apt-get install -y curl build-essential gcc g++ make yarn libssl-dev pkg-config
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sh -
RUN apt-get install -y nodejs

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
 
RUN /root/.cargo/bin/cargo install wasm-pack 
RUN /root/.cargo/bin/cargo install wasm-bindgen-cli
RUN ln -s /root/.cargo/bin/* /bin/
  
WORKDIR /client
 
RUN yarn install
 
EXPOSE 8000:8000
 
CMD ["/bin/bash", "-c", "yarn install && yarn run dev"]
 