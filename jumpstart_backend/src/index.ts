import { fastify } from "fastify";

const app = fastify({
    logger: true
})

const port = Number(process.env.PORT) || 8080;



app.listen({ port }, async (err, address)=> {
    if (err) {
        app.log.error(err)
        process.exit(1)
      }
    console.log("Server started")
})
