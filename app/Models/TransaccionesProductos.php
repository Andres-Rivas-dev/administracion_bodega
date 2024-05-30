<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransaccionesProductos extends Model
{
    use HasFactory;

    protected $table = 'transacciones_productos';
    protected $primaryKey = 'id';
    public $timestamps = true;

    protected $fillable = [
        'ingresado_por',
        'id_producto',
        'UPC',
        'created_at',
        'updated_at'
    ];

}
