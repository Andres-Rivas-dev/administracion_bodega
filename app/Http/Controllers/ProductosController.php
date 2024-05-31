<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Models\Productos;
use App\Models\Proveedores;
use App\Models\TransaccionesProductos;
use App\Helpers\calculoUpc;
use Illuminate\Support\Facades\Auth;

class ProductosController extends Controller
{

    public function getAllProductos(){

        $get = Productos::get();

        return $get;
    }

    public function registrarProducto(Request $request){

        if (empty($request)) {
            return  ['message' => 'Datos vacios'];
        }

        $validator = Validator::make($request->all(), [
            'nombre'             => 'required',
            'id_proveedor'       => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        DB::beginTransaction();

        try{

            $prod   = new Productos();
            $prod->nombre       = $request->nombre;
            $prod->id_proveedor = $request->id_proveedor;
            $prod->save();

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json('(error: ' . $e->getCode() . ") " . $e->getMessage());
        }
        
        DB::commit();

        return response()->json($prod, 201);        
    }

    public function registrarProveedor(Request $request){

        if (empty($request)) {
            return  ['message' => 'Datos vacios'];
        }

        $validator = Validator::make($request->all(), [
            'nombre'             => 'required',
            'telefono'           => 'required',
            'direccion'          => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        DB::beginTransaction();

        try{

            $prov   = new Proveedores();
            $prov->nombre_proveedor       = $request->nombre;
            $prov->telefono     = $request->telefono;
            $prov->direccion    = $request->direccion;
            $prov->save();

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json('(error: ' . $e->getCode() . ") " . $e->getMessage());
        }
        
        DB::commit();

        return response()->json($prov, 201);        
    }


    public function transaccionesInventario(Request $request){

        if (empty($request)) {
            return  ['message' => 'Datos vacios'];
        }

        $validator = Validator::make($request->all(), [
            'id_producto'             => 'required',
            'id_tipo_transaccion'     => 'required|integer',
            'cantidad'                => 'required|integer',
            'upc'                     => 'integer|exists:transacciones_productos,UPC|required_if:id_tipo_transaccion,2,3,4'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        DB::beginTransaction();

        try{

            $user = Auth::user();

            $prod   = new TransaccionesProductos();
            $prod->ingresado_por       = $user->id;
            $prod->id_producto         = $request->id_producto;
            if($request->id_tipo_transaccion == 1){
                $upc = calculoUpc::generateUPC();
                $prod->UPC             = $upc;
            }else{
                //no puede existir un producto que salga, se devuelva o se aruine dos veces en el inventario
                //por lo tanto se valida no exista un registro de salida, devolucion o perdida, devolviendo un mensaje
                $exist = TransaccionesProductos::where('UPC', $request->upc)->where('accion', $request->id_tipo_transaccion)->first();
                if($exist != null){
                    return response()->json("Operacion para articulo repetido", 200);
                }

                $prod_where   = TransaccionesProductos::where('UPC', $request->upc)->first();
                $prod->UPC             = $prod_where->UPC;
            }
            $prod->accion              = $request->id_tipo_transaccion; //llave foranea de tipo_transacciones
            $prod->save();

            $prod   = Productos::where('id', $request->id_producto)->first();
            $prod->cantidad            = $request->cantidad;
            $prod->save();

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json('(error: ' . $e->getCode() . ") " . $e->getMessage());
        }
        
        DB::commit();

        return response()->json($prod, 201);
    }


    
    
   
}
