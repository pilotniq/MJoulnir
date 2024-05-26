/*
 * From https://www.section.io/engineering-education/how-to-create-a-simple-rest-api-using-typescript-and-nodejs/
 */
import * as Model from "./model"
import * as BoatModel from "./boatModel"
import { ElectricDrivetrainStateMachine } from "./stateMachine"
import http from 'http';
import express, { Express } from 'express';
import { Request, Response, NextFunction } from 'express';
import morgan from 'morgan';
// import routes from './routes/posts';

const router: Express = express();

var stateMachine: ElectricDrivetrainStateMachine;
var model: BoatModel.BoatModel

export function start( model1: BoatModel.BoatModel, stateMachine1: ElectricDrivetrainStateMachine): void
{
  stateMachine = stateMachine1
  model = model1
  
/** Logging */
router.use(morgan('dev'));

/** Parse the request */
router.use(express.urlencoded({ extended: false }));

/** Takes care of JSON data */
router.use(express.json());

/** RULES OF OUR API */
router.use((req, res, next) => {
    // set the CORS policy
    res.header('Access-Control-Allow-Origin', '*');
    // set the CORS headers
    res.header('Access-Control-Allow-Headers', 'origin, X-Requested-With,Content-Type,Accept, Authorization');
    // set the CORS method headers
    if (req.method === 'OPTIONS') {
        res.header('Access-Control-Allow-Methods', 'GET PATCH DELETE POST');
        return res.status(200).json({});
    }
    next();
});

  /** Routes */
  const routes = express.Router();
  routes.post('/api/v1/state', setState );
  routes.get('/api/v1/state', getState );
  routes.get('/api/v1/battery/soc', getBatterySoc);
  routes.get('/api/v1/power', getPower);
  
  router.use('/', routes);

  /** Error handling */
  router.use((req, res, next) => {
    const error = new Error('not found');
    return res.status(404).json({
        message: error.message
    });
});

  /** Server */
  const httpServer = http.createServer(router);
  const PORT: any = process.env.PORT ?? 6060;
  httpServer.listen(PORT, () => console.log(`The server is running on port ${PORT}`));
}

const setState = async (req: Request, res: Response, next: NextFunction) => {
    // get the data from req.body
    // let title: string = req.body.title;
    // let body: string = req.body.body;
    // add the post
    console.log("Got body: " + req.body );
    console.log("New state: " + req.body.state );

    const newState: BoatModel.State = req.body.state!
    let result = stateMachine.requestTransition( newState as BoatModel.State )

    if(result) {
        return res.status(200).json({
    		   message: "OK"
    		   });
    }
    else {
    	 return res.status(500).json({message: "Failed"});
    }
    };

const getState = async (req: Request, res: Response, next: NextFunction) => {
      return res.status(200).json({ "state": model.state.state });
}

const getBatterySoc = async (req: Request, res: Response, next: NextFunction) => {
      return res.status(200).json({ "soc": model.battery.soc_from_min_voltage() });
}

const getPower = async (req: Request, res: Response, next: NextFunction) => {
      return res.status(200).json({ "power": model.battery.estimated_power });
}
