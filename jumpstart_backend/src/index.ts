import fastify from 'fastify';


const application = fastify({
    logger: true
})


application.get('/', async (request, response) => {
    
})