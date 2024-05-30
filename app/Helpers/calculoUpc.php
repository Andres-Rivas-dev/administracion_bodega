<?php

namespace App\Helpers;

use Illuminate\Support\Facades\DB;

class calculoUpc
{
    /**
     * Genera un unico digito de 12 caracteres numero de UPC.
     *
     * @return string
     */
    public static function generateUPC()
    {
        do {
            // genera los primero 11 digitos aleatorios
            $upc = str_pad(mt_rand(0, 99999999999), 11, '0', STR_PAD_LEFT);
            
            // Calculate check digit
            $checkDigit = self::calculateCheckDigit($upc);
            
            // Append check digit to the UPC
            $upc .= $checkDigit;
            
            // Check if the UPC already exists in the database
            $exists = DB::table('transacciones_productos')->where('UPC', $upc)->exists();
            
        } while ($exists);

        return $upc;
    }

    /**
     * Calculate the check digit for a UPC.
     *
     * @param string $upc
     * @return int
     */
    private static function calculateCheckDigit($upc)
    {
        $sumOdd = 0;
        $sumEven = 0;
        
        // Calculate the sum of odd and even positioned digits
        for ($i = 0; $i < 11; $i++) {
            if (($i % 2) == 0) {
                $sumOdd += $upc[$i];
            } else {
                $sumEven += $upc[$i];
            }
        }
        
        // Calculate the total sum
        $totalSum = ($sumOdd * 3) + $sumEven;
        
        // Calculate the modulo 10 of the total sum
        $modulo = $totalSum % 10;
        
        // Calculate the check digit
        $checkDigit = ($modulo == 0) ? 0 : (10 - $modulo);
        
        return $checkDigit;
    }
}
