/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { Contract } = require('fabric-contract-api');

class CollationContract extends Contract {

    async collationExists(ctx, collationId) {
        const buffer = await ctx.stub.getState(collationId);
        return (!!buffer && buffer.length > 0);
    }

    async createCollation(ctx, collationId, value) {
        const exists = await this.collationExists(ctx, collationId);
        if (exists) {
            throw new Error(`The collation with ${collationId} already exists`);
        }
        const asset = { value };
        const buffer = Buffer.from(JSON.stringify(asset));
        await ctx.stub.putState(collationId, buffer);
    }

    async readCollation(ctx, collationId) {
        const exists = await this.collationExists(ctx, collationId);
        if (!exists) {
            throw new Error(`The collation ${collationId} does not exist`);
        }
        const buffer = await ctx.stub.getState(collationId);
        const asset = JSON.parse(buffer.toString());
        return asset;
    }

    async updateCollation(ctx, collationId, newValue) {
        const exists = await this.collationExists(ctx, collationId);
        if (!exists) {
            throw new Error(`The collation with ${collationId} does not exist`);
        }
        const asset = { value: newValue };
        const buffer = Buffer.from(JSON.stringify(asset));
        await ctx.stub.putState(collationId, buffer);
    }

    async deleteCollation(ctx, collationId) {
        const exists = await this.collationExists(ctx, collationId);
        if (!exists) {
            throw new Error(`The collation ${collationId} does not exist`);
        }
        await ctx.stub.deleteState(collationId);
    }

    /*async queryAllAssets(ctx) {
        const startKey = '000';
        const endKey = '999';
        const iterator = await ctx.stub.getStateByRange(startKey, endKey);
        const allResults = [];
        while (true) {
            const res = await iterator.next();
            if (res.value && res.value.value.toString()) {
                console.log(res.value.value.toString());

                const Key = res.value.key;
                let Record;
                try {
                    Record = JSON.parse(res.value.value.toString());
                } catch (err) {
                    console.log(err);
                    Record = res.value.value.toString();
                }
                allResults.push({ Key, Record });
            }
            if (res.done) {
                console.log('end of data');
                await iterator.close();
                console.info(allResults);
                return JSON.stringify(allResults);
            }
        }
    }*/

}

module.exports = CollationContract;
